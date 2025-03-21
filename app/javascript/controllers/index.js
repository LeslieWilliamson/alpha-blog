// Import and register all your controllers from the importmap via controllers/**/*_controller
// import { application } from "controllers/application"
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)
import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)
