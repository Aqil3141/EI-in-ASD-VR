document.querySelectorAll('.header_scenarios').forEach(header => {
    header.addEventListener('click', () => {
        const content = header.nextElementSibling;

        if (content.computedStyleMap.display === 'block') {
            content.style.display = 'none';
        } else {
            document.querySelectorAll('.data_content').forEach(c => c.style.display = 'none');
            content.style.display = 'block';
        }
    });
});