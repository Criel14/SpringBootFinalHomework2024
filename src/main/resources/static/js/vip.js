// 页面加载完成后显示弹窗
window.onload = function() {
    updateQrcode();

    var isVip;
    fetch('/isVip')
        .then(response => response.json())
        .then(data => {
            isVip = data;
            console.log(data);
        })
        .catch(error => {
            console.error('Error:', error);
        });

    if (isVip) {
        document.getElementById('paymentPopup').style.display = 'none';
        const vipButton = document.querySelector('.vip-button');
        document.querySelector('.vip-title').innerText = '你已是尊贵的vip，专享4K超高清，极速观影特权';
        vipButton.innerText = "会员专享";
        vipButton.onclick = vipMovie;
    }
};

// 切换充值档位
function selectPlan(planId) {
    const plans = document.querySelectorAll('.plan');
    plans.forEach(plan => plan.classList.remove('selected'));
    plans.forEach(plan => plan.classList.remove('selectedMid'));
    document.getElementById(planId).classList.add('selected');
    document.getElementById('plan-selector').style.backgroundColor = '#fff7e6';
    if (planId === 'platinumVip') {
        document.getElementById('goldVip').classList.add('selectedMid');
        document.getElementById('diamondVip').classList.add('selectedMid');
        document.getElementById('plan-selector').style.backgroundColor = '#fff';
    }

    var yearlyPrice = document.getElementById('yearly').querySelector('.price');
    var quarterlyPrice = document.getElementById('quarterly').querySelector('.price');
    var monthlyPrice = document.getElementById('monthly').querySelector('.price');

    var originalYearlyPrice = document.getElementById('yearly').querySelector('.original-price');
    var originalQuarterlyPrice = document.getElementById('quarterly').querySelector('.original-price');
    var originalMonthlyPrice = document.getElementById('monthly').querySelector('.original-price');

    if (planId === 'goldVip') {
        yearlyPrice.innerText = '￥148';
        quarterlyPrice.innerText = '￥50';
        monthlyPrice.innerText = '￥15';

        originalYearlyPrice.innerText = '￥238';
        originalQuarterlyPrice.innerText = '￥68';
        originalMonthlyPrice.innerText = '￥25';

    } else if (planId === 'platinumVip') {
        yearlyPrice.innerText = '￥198';
        quarterlyPrice.innerText = '￥88';
        monthlyPrice.innerText = '￥20';

        originalYearlyPrice.innerText = '￥288';
        originalQuarterlyPrice.innerText = '￥108';
        originalMonthlyPrice.innerText = '￥30';
    } else {
        yearlyPrice.innerText = '￥248';
        quarterlyPrice.innerText = '￥128';
        monthlyPrice.innerText = '￥30';

        originalYearlyPrice.innerText = '￥358';
        originalQuarterlyPrice.innerText = '￥168';
        originalMonthlyPrice.innerText = '￥50';
    }
    updateAmountDisplay();
    updateQrcode();
}

//更新二维码
function updateQrcode() {
    const selectedDuration = document.querySelector('.duration.selected');
    const selectedPlan = document.querySelector('.plan.selected');
    const price = selectedDuration.querySelector('.price').innerText.slice(1);
    const subject = "G543电影网" + selectedPlan.textContent.trimStart().slice(0, 5)
        + selectedDuration.textContent.trimStart().slice(0, 4);

    fetch(`/pay?price=${price}&subject=${subject}`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => response.json())
        .then(data => {
            // 获取二维码字符串
            const qrCodeText = data.qr_code;

            const canvas = document.getElementById('qrCode');
            QRCode.toCanvas(canvas, qrCodeText, function (error) {
                if (error) {
                    console.error('生成二维码失败:', error);
                }
            });
            canvas.style.width = '130px';
            canvas.style.height = '130px';
        });
}

// 切换充值期限
function selectDuration(durationId) {
    const durations = document.querySelectorAll('.duration');
    durations.forEach(duration => duration.classList.remove('selected'));
    document.getElementById(durationId).classList.add('selected');
    updateAmountDisplay();
    updateQrcode();
}

// 更新金额显示
function updateAmountDisplay() {
    const selectedPlan = document.querySelector('.plan.selected');
    const selectedDuration = document.querySelector('.duration.selected');
    const amountDisplay = document.querySelector('.amount-display');
    const discount = document.querySelector('.discount');
    const price = selectedDuration.querySelector('.price').innerText;
    amountDisplay.innerText = price;
    discount.innerText = `共减 ￥${getDiscount(price)}`;
}

// 计算折扣
function getDiscount(price) {
    const originalPrices = {
        "￥148": 238,
        "￥50": 68,
        "￥15": 25,
        "￥198": 288,
        "￥88":108,
        "￥20":30,
        "￥248":358,
        "￥128":168,
        "￥30":50
    };
    const currentPrice = parseFloat(price.replace('￥', ''));
    const discount = originalPrices[price] - currentPrice;
    return discount.toFixed(2);
}

function closeWindow() {
    document.getElementById('paymentPopup').style.display = 'none';
}

function popWindow() {
    document.getElementById('paymentPopup').style.display = 'flex';
}

function vipMovie() {
    window.location.href = "http://localhost:8090/vipMovie";
}