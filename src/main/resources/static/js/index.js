// ����ʧЧ����֪��Ϊʲô

$(function () {

        //���������ӱ���
        $(".navMenu").each(function () {
            $(this).children(".navContent").hide();
        });

        //���˵����е�������������¼�
        $(".navTitle").each(function () {
            //��ȡ�����ǰ��ǩ�������ӱ�ǩ
            var navConEle = $(this).parents(".navMenu").children(".navContent");

            //�󶨵���¼�,�ж�navConEle��display��������Ƿ�Ϊnone,ʱnone�Ļ�ʱ����״̬
            $(this).click(function () {
                if (navConEle.css("display") != "none") {
                    //����,�������Դ�����,��λΪ����
                    navConEle.hide(300);
                } else {
                    //��ʾ,�������Դ�����,��λΪ����
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
