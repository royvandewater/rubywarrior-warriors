class Player
  DIRECTIONS = [:forward, :backward, :left, :right]
  def initialize
    @health = 0
  end

  def init!(warrior)
    @warrior = warrior
    @took_damage if @warrior.health < @health
    @health = @warrior.health
  end

  def play_turn(warrior)
    init! warrior

    return attack! direction_of_enemy if enemy_in_striking_distance?
    return rest! unless rested?

    walk! :in => direction_of_stairs
  end

  def attack!(direction=:forward)
    @warrior.attack! direction
  end

  def direction_of_enemy
    DIRECTIONS.select{|direction| feel(direction).enemy?}.first
  end

  def direction_of_stairs
    @warrior.direction_of_stairs
  end

  def enemy_in_striking_distance?
    return DIRECTIONS.any? {|direction| feel(direction).enemy?}
  end

  def feel(direction=:forward)
    @warrior.feel direction
  end

  def rest!
    @warrior.rest!
  end

  def rested?
    @health == 20
  end

  def walk!(options=nil)
    direction = :forward
    direction = options[:in] if options.is_a? Hash
    direction = options if options.is_a? Symbol
    @warrior.walk! direction
  end
end
