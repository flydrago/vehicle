CKEDITOR.editorConfig = (config) ->
  config.language = 'zh'
  config.filebrowserImageBrowseUrl = '/pictures/upload'
  config.filebrowserImageUploadUrl = '/wines/picture_upload'
  config.toolbar_Pure = [
    '/'
    {
      name: 'basicstyles'
      items: [
        'Bold'
        'Italic'
        'Underline'
        'Strike'
        'Subscript'
        'Superscript'
        '-'
        'RemoveFormat'
      ]
    }
    {
      name: 'paragraph'
      items: [
        'NumberedList'
        'BulletedList'
        '-'
        'Outdent'
        'Indent'
        '-'
        'Blockquote'
        '-'
        'JustifyLeft'
        'JustifyCenter'
        'JustifyRight'
        'JustifyBlock'
        '-'
        'BidiLtr'
        'BidiRtl'
      ]
    }
    {
      name: 'links'
      items: [
        'Link'
        'Unlink'
      ]
    }
    '/'
    {
      name: 'styles'
      items: [
        'Styles'
        'Format'
        'Font'
        'FontSize'
      ]
    }
    {
      name: 'colors'
      items: [
        'TextColor'
        'BGColor'
      ]
    }
    {
      name: 'insert'
      items: [
        'Image'
        'Table'
        'HorizontalRule'
        'PageBreak'
      ]
    }
  ]
  config.toolbar = 'Pure'
  true

# ---
# generated by js2coffee 2.1.0