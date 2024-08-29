// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
    document.addEventListener("click", e => {
        let elem;
        if (e.target.tagName == "TR") if (e.target.dataset.url) elem = e.target;
        if (e.target.tagName == "TD") if (e.target.parentElement.dataset.url) elem = e.target.parentElement;
        if (elem) location.href = elem.dataset.url;
    })
})
