document.addEventListener('DOMContentLoaded', function(){
  const postForm = document.getElementById('item-image');
  const previewList = document.getElementById('previews'); //プレビューを表示するスペースを取得
  if (!postForm) return null; //新規投稿・編集ページのフォームがないならここで終了。「!」は論理否定演算子。

  //input要素を取得
  const fileField = document.querySelector('input[type="file"][name="product[image]"]');
  fileField.addEventListener('change', function(e){ //変更が入ったときにイベント発火
    const file = e.target.files[0]; //発火したイベントeの中の、targetの中の、filesという配列に格納された画像ファイルを取得
    const blob = window.URL.createObjectURL(file); //引数fileを参照するURLを生成
    //ここから画像を表示するためのdiv要素を生成
    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');
    //ここまで画像を表示するためのdiv要素を生成
    //ここから表示する画像を生成
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('src', blob);
    //ここまで表示する画像を生成
    //ここから生成したHTML要素をブラウザに表示
    previewWrapper.appendChild(previewImage);//指定した親要素の子要素としてHTML要素を追加
    previewList.appendChild(previewWrapper);
    //ここまで生成したHTML要素をブラウザに表示
  });
});