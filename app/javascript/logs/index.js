//<script>
window.addEventListener("DOMContentLoaded", () => {
    for (let elem of document.querySelectorAll("tr:not(:first-child)")) {
        elem.addEventListener("click", () => {
            location.href = elem.dataset.url;
        })
    }

    const dropFileForm = document.getElementById("dropFileForm");
    document.body.addEventListener("dragover", e => { e.preventDefault(); })
    document.body.addEventListener("dragenter", e => { e.preventDefault(); })
    document.body.addEventListener("dragleave", e => { e.preventDefault(); })
    document.body.addEventListener("drop", e => {
        e.preventDefault();
        dropFileForm.querySelector("input[type='file']").files = e.dataTransfer.files;
        dropFileForm.submit();
    })
})
