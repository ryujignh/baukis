class Admin::StaffMembersController < Admin::Base

  def index
    @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
  end

  # updateで失敗した場合、URLを他のブラウザに貼り付けてアクセスするとshowへアクセスが走るので、リダイレクトする
  def show
    staff_member = StaffMember.find(params[:id])
    redirect_to [ :edit, :admin, staff_member ]
  end

  def new
    @staff_member = StaffMember.new
  end

end
