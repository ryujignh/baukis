class Admin::StaffEventsController < Admin::Base

  def index
    # For specific staff member's event
    if params[:staff_member_id]
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events.order(occurred_at: :desc)
    else
      # For all staff members events
      @events = StaffEvent.order(occurred_at: :desc)
    end
  end
end
