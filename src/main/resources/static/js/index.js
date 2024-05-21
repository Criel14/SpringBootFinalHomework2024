// 引用失效，不知道为什么

$(function () {

        //隐藏所有子标题
        $(".navMenu").each(function () {
            $(this).children(".navContent").hide();
        });

        //给菜单项中的所有主标题绑定事件
        $(".navTitle").each(function () {
            //获取点击当前标签下所有子标签
            var navConEle = $(this).parents(".navMenu").children(".navContent");

            //绑定点击事件,判断navConEle的display这个属性是否为none,时none的话时隐藏状态
            $(this).click(function () {
                if (navConEle.css("display") != "none") {
                    //隐藏,传参数自带动画,单位为毫秒
                    navConEle.hide(300);
                } else {
                    //显示,传参数自带动画,单位为毫秒
                    $(".nav-menu").each(function () {
                        $(this).children(".nav-content").hide(300);
                    });
                    navConEle.show(300);
                }
            });
        });

        $(".navContent>a").each(function () {
            $(this).click(function () {
                $(".content").html($(this).html());
            });
        });
    });
