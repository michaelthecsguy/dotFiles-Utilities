Before do |scenario|

  if REPORTING then
    if scenario.class == Cucumber::Ast::OutlineTable::ExampleRow then
      $scenario_count = scenario.scenario_outline.to_sexp[-1][-1].length - 2
      if $scenario_counter == 0 then
        $outline_message = ""
        $outline_name = scenario.scenario_outline.to_sexp[2]
      end
    end
  end

  
end

After do |scenario|
  
  if REPORTING then
    
    if scenario.class == Cucumber::Ast::OutlineTable::ExampleRow then
      $scenario_counter += 1
      if scenario.status == :failed then
        $outline_status = false
        $outline_message << scenario.exception.to_s
      elsif scenario.status == :passed then
        $outline_status = true unless $outline_status == false
      end
      if $scenario_counter == $scenario_count then
        $scenario_counter = 0
        case $outline_status
        when true 
          status = 'p'
        when false
          status = 'f'
        else
          status = 'b'
        end
        $scenario_status = 'empty'
        submitTCReport $outline_name, TestProject, TestPlan, TestBuild, status, $outline_message
      end
    else
      case scenario.status
      when :passed
        status = 'p'
      when :failed
        status = 'f'
      else
        status = 'b'
      end
      notes = scenario.exception.to_s
      submitTCReport scenario.name, TestProject, TestPlan, TestBuild, status, notes
    end
  
  end  
  
end
