const tabBtns = document.querySelectorAll('.tab-btn');
const forms = document.querySelectorAll('form');

tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
        const target = document.querySelector(btn.dataset.target);

        tabBtns.forEach(btn => btn.classList.remove('active'));
        forms.forEach(form => form.classList.remove('active'));

        btn.classList.add('active');
        target.classList.add('active');
    });
});