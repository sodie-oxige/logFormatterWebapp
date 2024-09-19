// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
    document.addEventListener("click", e => {
        if (!!e.target.closest("[data-url]")) {
            if (!!e.target.closest("turbo-frame")) {
                turboNavigate(e.target.closest("[data-url]").dataset.url, { frame: e.target.closest("turbo-frame").id });
            } else {
                turboNavigate(e.target.closest("[data-url]").dataset.url);
            }
        }
        if (!!e.target.closest(".nav_menubutton")) {
            document.getElementById("sidebar").classList.toggle("open");
            e.target.closest(".nav_menubutton").classList.toggle("open");
        }
    })
})
function turboNavigate(url, options = {}) {
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