class Admin::StaffEventsController < Admin::Base

  def index
    # For specific staff member's event
    if params[:staff_member_id]
      @staff_member = StaffMember.find(params[:staff_member_id])
      @events = @staff_member.events
    else
      # For all staff members events
      @events = StaffEvent
    end
    @events = @events.order(occurred_at: :desc)
                .includes(:member).page(params[:page])
    # .includes for N + 1 problem
    # .page for pagination
    # @eventsオブジェクトににLIMIT節を加えて、新しくクエリを発行している
    # StaffEvent Load (0.2ms)  SELECT  `staff_events`.* FROM `staff_events`  WHERE `staff_events`.`staff_member_id` = 1 LIMIT 10 OFFSET 0
  end
end
