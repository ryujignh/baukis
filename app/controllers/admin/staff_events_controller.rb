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
    # for pagination
    # @eventsオブジェクトににLIMIT節を加えて、新しくクエリを発行している
    # StaffEvent Load (0.2ms)  SELECT  `staff_events`.* FROM `staff_events`  WHERE `staff_events`.`staff_member_id` = 1 LIMIT 10 OFFSET 0
    @events = @events.page(params[:page])
  end
end
