data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_container_registry" "acr" {
  name = var.registryname
  resource_group_name = var.resource_group_name
}

resource "azurerm_log_analytics_workspace" "wspace" {
  name = "movies-log-workspace"
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku = "PerGB2018"
  retention_in_days = "30"
}

resource "azurerm_container_app_environment" "cae" {
  name = "movie-enviroment"
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_user_assigned_identity" "uai" {
  location = data.azurerm_resource_group.rg.location
  name = "user-identity"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_role_assignment" "rassign" {
  scope = data.azurerm_container_registry.acr.id # jag vill bara ge rättigheter till container_regisrtriet
  role_definition_name = "AcrPull"
  principal_id = azurerm_user_assigned_identity.uai.principal_id # detta idet är kopplat till resource "azurerm_user_assigned_identity" "uai" 
}

resource "azurerm_container_app" "bapp" {
    name = "backend"
    container_app_environment_id = azurerm_container_app_environment.cae.id
    resource_group_name = data.azurerm_resource_group.rg.name
    revision_mode = "Single"

  template {
    container {
        name = "backendapp"
        image = "moviesregistry.azurecr.io/backend:${var.image_tag}" # moviesRegistry är namnet på container_regoistry
        cpu = "1"
        memory = "2Gi"
    }
  }

  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uai.id]
  }

  registry {
    server = data.azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.uai.id
  }

  ingress {
    target_port = 8000
    external_enabled = true # denna är false som default

    traffic_weight {
        percentage = 100
        latest_revision = true # eftersom jag har revision_mode "Single" måste denna vara true
    }
  }
}

resource "azurerm_container_app" "fapp" {
  name = "frontend"
  container_app_environment_id = azurerm_container_app_environment.cae.id
  resource_group_name = data.azurerm_resource_group.rg.name
  revision_mode = "Single"
  
  template {
    container {
        name = "frontendapp"
        image = "moviesregistry.azurecr.io/frontend:${var.image_tag}" # moviesRegistry är namnet på container_regoistry"
        cpu = 1
        memory = "2Gi"

        # env.name är namnet på miljövariabeln själv (BACKEND_URL), inte containerns namn.
          # Läses i Python med os.getenv("BACKEND_URL"), default där är 127.0.0.1:8000
          # vilket bara pekar på sig själv inuti containern om denna variabel saknas.
        env {
          name = "BACKEND_URL"
          value = "https://${azurerm_container_app.bapp.ingress[0].fqdn}"
        }
    }
  }
  identity {
    type = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.uai.id]
  }

  registry {
    server = data.azurerm_container_registry.acr.login_server
    identity = azurerm_user_assigned_identity.uai.id
  }

  ingress {
    target_port = 8501
    external_enabled = true

    traffic_weight {
        percentage = 100
        latest_revision = true  # eftersom jag har revision_mode = single, så blir denna true
    }
  }
}



