function search(content) {
    var query = document.querySelector('.search-input').value;
    if (content != null) query = content; //�˺���Ĭ��ѡ�����������ַ���Ϊ��ѯ����

    if (query) {
        // �����������󵽺��
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/search/movieList', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onload = function () {
            if (xhr.status === 200) {
                document.querySelector('.trending').classList.add('hidden');
                var searchBar = document.querySelector('.search-bar');
                var logoLink = document.querySelector('.logo-link');
                searchBar.classList.add('top-bar');
                searchBar.insertBefore(logoLink, searchBar.firstChild); // ��logoLink���뵽searchBar����ǰ��

                // ���� JSON ��Ӧ
                var movieList = JSON.parse(xhr.responseText);
                console.log(movieList);
                if (movieList.length === 0) {
                    document.querySelector('.empty-result').classList.remove('hidden');
                } else {
                    document.querySelector('.results-container').classList.remove('hidden');
                    var resultsList = document.querySelector('.results-container ul');
                    resultsList.innerHTML = '';

                    movieList.forEach(function (movie) {
                        var li = document.createElement('li');
                        li.classList.add('movie-item');
                        var img = document.createElement('img');
                        img.src = "/cover/"
                        img.src += movie.movieCoverUrl; // ʹ�� movieCoverUrl ����
                        img.alt = movie.movieTitle; // ʹ�� movieTitle ����
                        var name = document.createElement('div');
                        name.classList.add('name');
                        name.textContent = movie.movieTitle; // ʹ�� movieTitle ����
                        li.appendChild(img);
                        li.appendChild(name);
                        resultsList.appendChild(li);
                    });
                }
            } else {
                console.error('Error:', xhr.statusText); // ������
            }
        };
        xhr.send('query=' + encodeURIComponent(query)); // ��������������
    }
}

document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.empty-result').classList.add('hidden');
    document.querySelector('.results-container').classList.add('hidden');
    var searchInput = document.querySelector('.search-input');
    var searchButton = document.querySelector('.search-button');

    // ���������ťʱ��������
    searchButton.addEventListener('click', function () {
        search();
    });

    // ���»س���ʱ��������
    searchInput.addEventListener('keypress', function(event) {
        if (event.key === 'Enter') {
            search();
        }
    });

    // ���������Ŀʱ��������
    var trendingItems = document.querySelectorAll('.trending li');
    trendingItems.forEach(function(item) {
        item.addEventListener('click', function() {
            var query = item.textContent.trim().slice(2);
            document.querySelector('.search-input').value = query;
            search(query);
        });
    });
});