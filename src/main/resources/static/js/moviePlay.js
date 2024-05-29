// 电影类型映射
const typeMapping = {
    "comedy": "喜剧",
    "action": "动作",
    "animation": "动画",
};


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
                console.log(response)
                const resMovie = response.resMovie;
                const resUser = response.resUser;
                const resDirectors = response.resDirectors;
                const resActors = response.resActors;

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

                // 类型地区
                const typeAndRegion = document.createElement('p');
                typeAndRegion.classList.add('movie-type-and-region');
                const movieType = typeMapping[resMovie.movieType]
                typeAndRegion.textContent = movieType + ' / ' + resMovie.movieRegion;

                // 评分
                const score = document.createElement('p');
                score.classList.add('movie-score');
                score.textContent = parseFloat(resMovie.movieScore).toFixed(1);

                // 导演和演员
                const staff = document.createElement('p');
                staff.classList.add('movie-staff');
                let directorsText = "导演：<br>";
                for (let i = 0; i < resDirectors.length; i++) {
                    directorsText += resDirectors[i] + "<br>";
                }
                let actorsText = "主演：<br>";
                for (let i = 0; i < resActors.length; i++) {
                    actorsText += resActors[i] + "<br>";
                }
                staff.innerHTML = directorsText + "<br>" + actorsText;

                // 电影信息——电影描述
                const description = document.createElement('p');
                description.classList.add('movie-description');
                description.textContent = "简介：" + resMovie.movieDescription.substring(0, 200);
                if (description.textContent.length >= 200) {
                    description.textContent += '...';
                }

                // 评分、类型、地区、staff


                // 加入元素
                const basicInfo = document.createElement('div');
                basicInfo.classList.add('basic-info');
                basicInfo.appendChild(title);
                basicInfo.appendChild(date);
                basicInfo.appendChild(typeAndRegion);
                basicInfo.appendChild(score);

                const movieInfo = document.querySelector(".movie-info")
                movieInfo.appendChild(cover);
                movieInfo.appendChild(basicInfo);
                movieInfo.appendChild(description);
                movieInfo.appendChild(staff);

                // 如果不是vip，就不显示视频
                const movieVideo = document.getElementById("bili-radio");
                const needVipTip = document.getElementById("need-vip-tip");
                fetch('/isVip')
                    .then(response => response.json())
                    .then(data => {
                        var isVip;
                        isVip = data;
                        if (isVip !== 1 && resMovie.needVip === 1) {
                            movieVideo.style.display = "none";
                            needVipTip.style.display = "block";
                        } else {
                            movieVideo.style.display = "block";
                            needVipTip.style.display = "none";
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                    });
            } else {
                console.error('Error:', xhr.statusText);
            }
        };
        xhr.send(`movieId=${movieId}`);
    } else {
        console.error('movieId not found in URL');
    }
}

// 进入会员中心
function toVipPage() {
    window.location.href = '/vip';
}