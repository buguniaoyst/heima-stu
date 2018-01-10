/**
 * 编程题模板
 * @type {string}
 */
var codeItemTemplate = '<div class="itemAnswerArea"   id="itemId" >\n' +
    '            <div class="site-title">\n' +
    '                <fieldset><legend><a >第1题</a></legend></fieldset>\n' +
    '            </div>\n' +
    '            <div class="site-item">\n' +
    '                itemContent\n' +
    '            </div>\n' +
    '        </div>\n' +
    '        <div class="layui-form-item layui-form-text">\n' +
    '            <label class="layui-form-label">请写下你的思路</label>\n' +
    '            <div class="layui-input-block">\n' +
    '                <textarea placeholder="请输入思路" cols="30" rows="10" class="layui-textarea silu"></textarea>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '        <div class="layui-form-item layui-form-text">\n' +
    '            <label class="layui-form-label">请将你的答案粘贴到下边的文本域中：</label>\n' +
    '            <div class="layui-input-block">\n' +
    '                <textarea placeholder="请输入答案" cols="30" rows="10" class="layui-textarea silu"></textarea>\n' +
    '            </div>\n' +
    '        </div>\n' +
    '        <div class="layui-input-block ">\n' +
    '            <button class="layui-upload-button">\n' +
    '                上传附件：<input  type="file" class="layui-btn layui-btn-primary" name="mp" onchange="uploadPic()" />\n' +
    '            </button>\n' +
    '            <input type="hidden" name="picPath" id="picPath"/>\n' +
    '        </div>';

