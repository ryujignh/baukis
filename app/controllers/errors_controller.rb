class ErrorsController < ApplicationController
	def routing_error
		# 第2引数でメッセージを指定する、
		# これはログや開発者向けのエラーペ0時に表示される。
		# メッセージに埋め込まれているrequest.path.inspectという式は、URLパスを二重引用符で囲んだ文字列を返す。

		# ActionController::RoutingErrorは本来ルーティング処理の段階で発生するが、
		# このように意図的にアクションの中で発生させることにより、
		# rescue_fromで補足出来るようにしている。
		raise ActionController::RoutingError,
			"No route matches #{request.path.inspect}"
	end
end
