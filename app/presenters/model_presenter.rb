# the purpose of this class is to move business logic
# from view templates so template is more readable.

class ModelPresenter
  attr_reader :object, :view_context
  # 委譲メソッド、view_contextオブジェクトが持っているrawメソッドを、
  # ModelPresenterのインスタンスメソッドとして定義している。
  # オブジェクトBのメソッドを自分のインスタンスメソッドして使えるようにする。
  # ModelPresenter.new.rawするとヘルパーメソッドのrawが呼び出される。
  delegate :raw, to: :view_context

  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end

end