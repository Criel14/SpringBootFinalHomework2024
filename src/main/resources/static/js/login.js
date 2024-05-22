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

function registerUser() {
    const registerForm = document.getElementById('register-form');
    const username = registerForm.username.value;
    const phoneNumber = registerForm.phoneNumber.value;
    const password = registerForm.password.value;
    const confirmPassword = registerForm.confirmPassword.value;

    // 进行前端验证
    if (password !== confirmPassword) {
        showRegisterError('两次输入的密码不一致');
        return;
    }

    // 发送注册请求
    fetch('/register', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            username: username,
            phoneNumber: phoneNumber,
            password: password
        })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // 注册成功,跳转到其他页面
                showRegisterSuccess('注册成功!请重新登陆');
            } else {
                // 注册失败,显示错误信息
                showRegisterError(data.message);
            }
        })
        .catch(error => {
            console.error('注册请求出错:', error);
            showRegisterError('注册请求出错');
        });
}

function showRegisterError(message) {
    const errorDiv = document.getElementById('registerError');
    errorDiv.textContent = message;
}

function showRegisterSuccess(message) {
    const successDiv = document.getElementById('registerSuccess');
    successDiv.textContent = message;
}

