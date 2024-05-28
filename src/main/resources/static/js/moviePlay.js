// 获取get参数
function getQueryParam(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// 进入页面接收后端传来的电影对象
window.onload = function () {
    const movieId = getQueryParam('movieId');
    if (movieId) {
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/moviePlay/movieInfo', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
            if (xhr.status === 200) {
                // 接收后端传来的电影对象
                const response = JSON.parse(xhr.responseText);
                const resMovie = response.resMovie;
                const resUser = response.resUser;
                console.log(resMovie)
                console.log(resUser)

                // 获取iframe元素
                var iframe = document.getElementById("bili-radio");
                // 设置新的src属性
                iframe.src = "https://" + resMovie.videoUrl;

                // 绘制内容
                // 电影封面
                const cover = document.createElement('img');
                cover.src = '/cover/' + resMovie.movieCoverUrl;
                cover.alt = resMovie.movieTitle;
                // 电影标题
                const title = document.createElement('p');
                title.classList.add('movie-title');
                title.textContent = resMovie.movieTitle;
                // 电影信息——上映日期
                const date = document.createElement('p');
                date.classList.add('movie-date');
                date.textContent = resMovie.releaseDate.split('T')[0];
                // 电影信息——电影描述
                const description = document.createElement('p');
                description.classList.add('movie-description');
                description.textContent = resMovie.movieDescription.substring(0, 200);
                if (description.textContent.length >= 200) {
                    description.textContent += '...';
                }

                // 评分、类型、地区、staff

                // 加入元素
                const movieInfo = document.querySelector(".movie-info")
                movieInfo.appendChild(cover);
                movieInfo.appendChild(title);
                movieInfo.appendChild(date);
                movieInfo.appendChild(description);
            } else {
                console.error('Error:', xhr.statusText);
            }
        };
        xhr.send(`movieId=${movieId}`);
    } else {
        console.error('movieId not found in URL');
    }
}