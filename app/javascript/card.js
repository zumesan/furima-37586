const pay = () => {

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); //環境変数に設定したPAY.JPテスト公開鍵
  const submit = document.getElementById("button"); //order/index.html.erb内のid"button"がクリックされた時に発火
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form"); //order/index.html.erb内のid"charge-form"を取得し、定数に格納
    const formData = new FormData(formResult);

    const card = { //ハッシュ_card生成
      number: formData.get("purchase_destination[number]"), //order/index.html.erb内のname属性"number"を取得し、定数に格納
      cvc: formData.get("purchase_destination[cvc]"),
      exp_month: formData.get("purchase_destination[exp_month]"),
      exp_year: `20${formData.get("purchase_destination[exp_year]")}`
    };

    Payjp.createToken(card, (status, response) => { //カード情報をトークン化、引数にstatus（うまく生成されたか確認）とresponse（レスポンスの内容）を定義
      if (status == 200) { //HTTPステータスコードが200のとき（うまく処理が完了したとき）、トークンの値を取得
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`; //トークンの値を非表示
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      //ここからフォームに存在するクレジットカード情報の削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      //ここまでフォームに存在するクレジットカード情報の削除

      document.getElementById("charge-form").submit(); //フォームの情報をサーバーサイドに送信
    });
  });
};

window.addEventListener("load", pay); //'load'でページ全体が全て読み込まれた後に、payイベント発火