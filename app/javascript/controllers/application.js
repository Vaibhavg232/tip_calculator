import { Application } from "@hotwired/stimulus"
import DataTable from "datatables.net-dt"
import * as jq from 'jquery';
import { default as $ } from 'jquery'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application
window.$ = $
window.jQuery = $
window.DataTable = DataTable()

export { application }
