workspace "Hot Diggety Dog" {
  model {
    group "External" {
      paymentPlatform = softwareSystem "Payment Platform"
      socialMedia = softwareSystem "Social Media"
    }

    group "Hot Diggety Dog" {
      standOperator = person "Stand Operator"
      inventoryStaff = person "Inventory Staff"
      customer = person "Customer"

      pos = softwareSystem "Point of Sale" {
        frontEnd = container "FrontEnd" {
          mobileApp = component "POS Mobile App"
          inventoryUI = component "Inventory Staff UI"
        }
        backend = container "BackEnd" {
          posBackend = component "POS Backend"
          inventoryManagementBackend = component "Inventory Managemenet Backend"
        }
        services = container "Services" {
          discountService = component "Discount Service"
          notificationService = component "Notification Service"
          socialMediaIntegration = component "Social Media Integration"
          exportDataService = component "Export Data Service"
          reportingService = component "Reporting Service"
        }
        storage = container "Storage" {
          customerDb = component "Customer Database"
          posPersistDb = component "POS Data Persist Database"
          reportingDb = component "Reporting Database"
        }
      }
    }

    pos -> paymentPlatform
    pos -> socialMedia

    standOperator -> pos
    inventoryStaff -> pos
    customer -> pos

    frontEnd -> backend
    backend -> services
    services -> storage

    mobileApp -> posBackend
    inventoryUI -> inventoryManagementBackend

    posBackend -> discountService
    posBackend -> customerDb
    posBackend -> posPersistDb
    inventoryManagementBackend -> posPersistDb

    discountService -> customerDb
    notificationService -> posBackend
    notificationService -> inventoryManagementBackend
    socialMediaIntegration -> customerDb
    socialMediaIntegration -> notificationService
    notificationService -> socialMedia
    reportingService -> reportingDb
    exportDataService -> posPersistDb

    customerDb -> posPersistDb
    posPersistDb -> reportingDb
  }

  views {
    systemLandscape "HotDiggetyDog" {
      include *
      autolayout
    }

    systemContext pos "SystemContext" {
      include *
      autoLayout
      properties {
        structurizr.groups false
      }
    }

    container pos "PointOfSale" {
      include *
      autolayout
    }

    component frontEnd "FrontEnd" {
      include *
      autoLayout
    }

    styles {
      element "Person" {
        shape person
        background #08427b
        color #ffffff
      }
    }
  }
}