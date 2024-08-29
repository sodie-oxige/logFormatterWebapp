document.body.addEventListener("dragover", e => { e.preventDefault(); })
document.body.addEventListener("dragenter", e => { e.preventDefault(); })
document.body.addEventListener("dragleave", e => { e.preventDefault(); })
document.body.addEventListener("drop", e => {
    e.preventDefault();
    const dropFileForm = document.getElementById("dropFileForm");
    dropFileForm.querySelector("input[type='file']").files = e.dataTransfer.files;
    dropFileForm.submit();
})