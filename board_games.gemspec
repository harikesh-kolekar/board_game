require_relative 'lib/board_games/version'

Gem::Specification.new do |spec|
  spec.name          = "board_games"
  spec.version       = BoardGames::VERSION
  spec.authors       = ["harikesh-kolekar"]
  spec.email         = ["harikeshkolekarr@gmail.com"]

  spec.summary       = %q{Design a board game.}
  spec.description   = %q{It can be played by 3 to 5 players. One of that should be assigned a task to manage money.
The board has 9 squares each along its sides and 4 special squares at corner (one of them is Start). The player has a choice to buy that square as per its value. When any other player comes to a square which belongs to some-other player, he has to play rent to that player. Each square represents either a Company, Garden, Museum, or Entertainment Park, Cinema Hall, Mall.
Players use dice turn by turn to move along the squares.}
  spec.homepage      = "https://github.com/harikesh-kolekar/board_game"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/harikesh-kolekar/board_game"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/harikesh-kolekar/board_game"
  spec.metadata["changelog_uri"] = "https://github.com/harikesh-kolekar/board_game"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "rake", "~> 12.0"
  spec.add_dependency "rspec", "~> 3.0"
  spec.add_dependency "colorize", '~> 0.8.1'
  spec.add_dependency "activesupport", '~> 7.0', '>= 7.0.8'
end
