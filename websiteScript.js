function toggleContent(header) {
    const content = header.nextElementSibling;
    content.style.display = content.style.display === "block" ? "none" : "block";
}