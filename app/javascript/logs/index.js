document.getElementById("main").addEventListener("dragover", e => { e.preventDefault(); })
document.getElementById("main").addEventListener("dragenter", e => { e.preventDefault(); })
document.getElementById("main").addEventListener("dragleave", e => { e.preventDefault(); })
document.getElementById("main").addEventListener("drop", e => {
    e.preventDefault();
    const dropFileForm = document.getElementById("dropFileForm");
    dropFileForm.querySelector("input[type='file']").files = e.dataTransfer.files;
    dropFileForm.submit();
})