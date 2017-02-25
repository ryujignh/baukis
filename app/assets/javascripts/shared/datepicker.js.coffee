$(document).on 'ready page:change', ->
  d = new Date()
  $.datepicker.setDefaults({
    dateFormat: "yy-mm-dd",
    minDate: new Date(2000, 1, 1),
    maxDate: new Date(d.getFullYear() + 1, d.getMonth(), d.getDate() - 1)
    })
  # .datepickerクラス属性があるDOMに入力フォーカスが当たると、
  # カレンダーが画面に表示される
  $('.datepicker').datepicker()