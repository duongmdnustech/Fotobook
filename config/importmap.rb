# Pin npm packages by running ./bin/importmap

# pin "application"
# pin "@hotwired/turbo-rails", to: "turbo.min.js"
# pin "@hotwired/stimulus", to: "stimulus.min.js"
# pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
# pin_all_from "app/javascript/controllers", under: "controllers"
# pin_all_from "app/javascript/components", under: "components"
# pin "components", to: "components/index.js" # Trỏ tên folder vào file index
# pin "bootstrap" # @5.3.8
# pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
# pin "bootstrap", to: "bootstrap.bundle.min.js"

# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/components", under: "components"
pin "components", to: "components/index.js"

# --- SỬA ĐOẠN NÀY ---
# Pin Bootstrap bản ESM (quan trọng đuôi .esm.js) để dùng được "import { Toast }"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.3/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js"
# --------------------