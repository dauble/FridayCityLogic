require_relative 'lib/driver'
require_relative 'lib/team'
require_relative 'lib/constructor'
require_relative 'lib/f1data'
require_relative 'lib/output'
require 'yaml'


@data = F1Data.new()

def generate_inter_change_suggestions
  for i in (1..3) do
    filename = 'myteam'+i.to_s+'.yml'
    if !File.exist?(filename)
      return
    end
    myteam = YAML.load_file(filename)
    unless myteam['drivers'].nil? || myteam['drivers'].empty?

      teamerrors= @data.valid_input_check(myteam)
      if teamerrors.length > 0
        print_team_errors(teamerrors)
        exit
      end
      print_current_team(myteam)

      teams = @data.generate_teams_list(myteam)
      print_interrace_teams(teams)
    end
  end
end

def generate_initial_teams
  teams = @data.generate_teams_list
  print_teams(teams)
end


generate_inter_change_suggestions()
generate_initial_teams()
