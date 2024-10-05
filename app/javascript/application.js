// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

window.turboNavigate = (url, options = {}) => {
    // フレームIDが指定されているかどうかを判定
    if (options.frame) {
        const frame = document.getElementById(options.frame);

        if (frame) {
            // Turbo Frame の src を変更してフレーム内だけを遷移
            frame.setAttribute('src', url);
        } else {
            console.error(`指定されたフレームID "${options.frame}" が見つかりません。`);
        }
    } else {
        // Turbo Drive を使って全体のページ遷移を実行
        Turbo.visit(url);
    }
}

document.addEventListener("DOMContentLoaded", () => {
    document.addEventListener("click", e => {
        if (!!e.target.closest("[data-url]")) {
            if (e.target.closest("[data-url]").dataset.turbo == "false") {
                location.href = e.target.closest("[data-url]").dataset.url;
            }
            else if (!!e.target.closest("turbo-frame")) {
                turboNavigate(e.target.closest("[data-url]").dataset.url, { frame: e.target.closest("turbo-frame").id });
            } else {
                turboNavigate(e.target.closest("[data-url]").dataset.url);
            }
        }
        if (!!e.target.closest(".selectButton")) {
            const container = e.target.closest(".selectButton");
            const value = e.target.closest("[data-value]").dataset.value;
            console.log(value);
            container.querySelector(".selected").classList.remove("selected");
            e.target.closest(".selectButton>*").classList.add("selected");
            container.querySelector("input[type='hidden']").value = value;
        }
        if (!!e.target.closest(".nav_menubutton")) {
            document.getElementById("sidebar").classList.toggle("open");
            e.target.closest(".nav_menubutton").classList.toggle("open");
        }
    })
})

// #main直下要素を.containerで囲う
{
    const wrapContainer = () => {
        const elements = document.querySelectorAll('#main > *:not(.container)');
        elements.forEach(element => {
            const container = document.createElement('div');
            container.classList.add('container');
            element.parentNode.insertBefore(container, element);
            container.appendChild(element);
        });
    }
    document.addEventListener("DOMContentLoaded", wrapContainer);
    document.addEventListener("turbo:load", wrapContainer);
}
// startup_maskを画面読み込み終了時に消去
window.addEventListener("load", () => {
    document.getElementById("startup_mask")?.classList.add("hidden");
})

// cache
if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/service-worker.js')
}
