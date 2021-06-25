Swap.transaction do
    Swap
    .find_each do |swap|
        if swap.intake_start_date.nil?
            swap.intake_start_date = swap.start_date-1
            swap.intake_end_date = swap.end_date-1
        end
        range = swap.intake_start_date..swap.intake_end_date
        swap.intake_dates = range.to_a
        ap "#{swap.id} | #{swap.intake_start_date} | #{swap.intake_end_date} | #{swap.intake_dates.join(',')}"
        # swap.save! validate: false
        swap.save!
    end    
end