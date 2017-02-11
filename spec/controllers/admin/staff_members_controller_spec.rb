require 'spec_helper'

describe Admin::StaffMembersController do
  let(:params_hash) { attributes_for(:staff_member) }

  describe '#create' do
    example '職員一覧ページにリダイレクト' do
      post :create, staff_member: params_hash
      # admin_staff_members_urlの代わりにadmin_staff_members_pathを使用すると
      # テストが失敗します。redirect_toの引数にURLパスのみを指定すると、
      # RSpecはtest.hostというホスト名を用いてURLを作り、それをリダイレクト先
      # と比較する。
      # Baukisではホスト名を用いてルーティングを設定しているので、リダイレクト先は、
      # http://baukis.example.com/admin/staff_membersのようになる。
      # redirect_toの引数にはURL全体を指定しなければ、正しくは比較できない。
      expect(response).to redirect_to(admin_staff_members_url)
    end

    example '例外ActionController::ParameterMissingが発生' do
      # bypass_resuce, specファイル特有のメソッドで、rescue_fromによる例外処理を無効にする効果がある。
      bypass_rescue
      expect { post :create }.to raise_error(ActionController::ParameterMissing)
    end
  end

  describe '#update' do
    let(:staff_member) { create(:staff_member) }

    example 'suspendedフラッグをオンにする' do
      params_hash.merge!(suspended: true)
      # update action, id => staff_member.id, :staff_member => {params_hash}
      patch :update, id: staff_member.id,  staff_member: params_hash
      staff_member.reload
      # be_suspended -> model.suspended?に変換される
      expect(staff_member).to be_suspended
    end

    example 'hashed_passwordの書き換えは不可' do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: 'x')
      expect {
        patch :update, id: staff_member.id, staff_member: params_hash
      }.not_to change { staff_member.hashed_password.to_s }
    end

  end
end