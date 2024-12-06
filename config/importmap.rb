pin "application"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "popper", to: 'popper.js', preload: true
pin "bootstrap", to: 'bootstrap.min.js', preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.1/dist/jquery.js"
pin "jquery1", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.js"
pin "datatables.net-dt", to: "https://ga.jspm.io/npm:datatables.net-dt@1.12.1/js/dataTables.dataTables.js"
pin "datatables.net", to: "https://ga.jspm.io/npm:datatables.net@1.12.1/js/jquery.dataTables.js"
