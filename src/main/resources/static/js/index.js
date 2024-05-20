window.onload = function () {
// 获取登录/注册链接和模态框元素
    const loginLink = document.getElementById('login-link');
    const loginModal = document.getElementById('login-modal');
    const closeBtn = document.querySelector('.close-btn');

// 获取登录/注册切换按钮和表单元素
    const tabBtns = document.querySelectorAll('.tab-btn');
    const forms = document.querySelectorAll('form');

// 点击登录/注册链接时显示模态框
    loginLink.addEventListener('click', (event) => {
        event.preventDefault(); // 防止链接默认行为
        loginModal.style.display = 'block';
    });

// 点击关闭按钮或模态框外部区域时隐藏模态框
    closeBtn.addEventListener('click', () => {
        loginModal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === loginModal) {
            loginModal.style.display = 'none';
        }
    });

// 登录/注册切换按钮功能
    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            const target = document.querySelector(btn.dataset.target);

            tabBtns.forEach(btn => btn.classList.remove('active'));
            forms.forEach(form => form.classList.remove('active'));

            btn.classList.add('active');
            target.classList.add('active');
        });
    });
}