// 进入页面接收后端传来的电影对象
window.onload = function () {
    const xhr = new XMLHttpRequest();
    xhr.open('POST', '/moviePlay', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onload = function () {
        if (xhr.status === 200) {
            var moive = JSON.parse(xhr.responseText);


        } else {
            console.error('Error:', xhr.statusText);
        }
    };
}

