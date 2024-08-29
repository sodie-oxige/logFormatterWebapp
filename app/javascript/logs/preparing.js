window.addEventListener("DOMContentLoaded", () => {
    let data = {};
    data.varsion = window.var;
    data.body = [];
    const shadowRoot = document.getElementById("html_container").shadowRoot;
    const comments = shadowRoot.querySelectorAll("p");
    let progress = document.querySelector(".mask>progress");
    progress.max = comments.length;
    for (progress.value = 0; progress.value < progress.max; progress.value++) {
        console.log(comments[progress.value]);
        let comment = comments[progress.value];
        let temp = comment.querySelectorAll("span");
        let comment_data = {
            color: comment.style.color,
            tab: temp[0].textContent.match(/(?<=\[).+(?=\])/)[0],
            author: temp[1].textContent,
            content: temp[2].textContent.replace(/^\s+/mg, "").replace(/\n$/, "")
        }
        data.body.push(comment_data);
    }
    console.log(data)
    console.log(window.fetch_path)
    fetch(window.fetch_path, {
        method: 'POST',
        body: JSON.stringify(data)
    }).then((res) => {
        console.log(res);
    })
})