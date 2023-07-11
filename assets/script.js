ClassicEditor
    .create(document.querySelector('#user_input'), {
        toolbar: [
            'heading',
            '|',
            'bold',
            'italic',
            '|',
            'alignment'
        ]
    })
    .then(editor => {
        const saveButton = document.querySelector('#SaveButton');
        saveButton.addEventListener('click', () => {
            const content = editor.getData();
            // 여기서 content 변수에 편집된 텍스트 내용이 들어옵니다.
            // 이곳에서 저장 로직을 작성하면 됩니다.
            console.log(content);
        });
    })
    .catch(error => {
        console.error(error);
    }); 

function sendData(){
    const editor = ClassicEditor.instance.editor;
    const content = editor.getData();

    return content;
}