// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
    document.addEventListener("click", e => {
        if (e.target.tagName == "TR") if (e.target.dataset.url) location.href = e.target.dataset.url;
        if (e.target.tagName == "TD") if (e.target.parentElement.dataset.url) location.href = e.target.parentElement.dataset.url;
        if (e.target.classList.contains("nav_menubutton")){
            document.getElementById("sidebar").classList.toggle("open");
            e.target.classList.toggle("open");
        }
        if (e.target.parentElement.classList.contains("nav_menubutton")){
            document.getElementById("sidebar").classList.toggle("open");
            e.target.parentElement.classList.toggle("open");
        }
    })
})