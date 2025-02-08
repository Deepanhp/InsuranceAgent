// Configure your import map in config/importmap.rb

// Core libraries
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
import jQuery from "jquery"
window.jQuery = jQuery
window.$ = jQuery

// Custom scripts
document.addEventListener("turbo:load", function() {
  // Initialize all Bootstrap tooltips
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })

  // Initialize all Bootstrap popovers
  var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
  })
}); 