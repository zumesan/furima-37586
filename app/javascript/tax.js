function tax (){ //関数'tax'を定義
  const itemPrice = document.getElementById("item-price"); //id:item-priceの値を取得し、定数に格納
  itemPrice.addEventListener("keyup",()=> { //keyupでキーを離したときにイベント発火させる
    const fee = Math.floor(itemPrice.value * 0.1); //Math.floorで小数点以下を切り捨て、定数に格納
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = `${fee}`; //innerHTMLで、4行目で定義した定数をHTMLに表示
    const SalesProfit = Math.floor(itemPrice.value - fee);
    const profit = document.getElementById("profit");
    profit.innerHTML = `${SalesProfit}`;
  });
}

window.addEventListener('load', tax); //'load'でページ全体が全て読み込まれた後に、taxイベント発火