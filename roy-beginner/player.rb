class Player
  def initialize
    @health = 0
    @walls_hit = 0
  end

  def init!(warrior)
    @warrior = warrior
    check_health!
  end

  def play_turn(warrior)
    init! warrior

    @walls_hit += 1 if feel.stairs?
    @walls_hit += 1 if feel(:backward).wall? || feel(:forward).wall?

    return pivot! if feel.wall?
    return pivot! if took_damage? && forward_enemy_threat_not_immediate?
    return shoot! if enemy_in_line_of_fire?
    return rescue! if feel.captive?
    return attack! unless feel.empty?
    return walk! :backward if took_damage? && low_health?
    return rest! unless took_damage? || rested?
    return pivot! if feel.stairs? && not_done_yet?
    walk!
  end

  def attack!
    @warrior.attack!
  end

  def check_health!
    @took_damage = @warrior.health < @health
    @health = @warrior.health
  end

  def enemy_in_line_of_fire?
    look.each do |space|
      next if space.empty?
      return false if space.captive?
      return true if space.enemy?
    end

    return false
  end

  def feel(direction=:forward)
    @warrior.feel direction
  end

  def forward_enemy_threat_not_immediate?
    look.each do |space|
      next if space.empty?
      return !['w','a'].include?(space.unit.character)
    end

    return false
  end

  def listen
    @warrior.listen
  end

  def look
    @warrior.look
  end

  def low_health?
    @warrior.health < 15
  end

  def not_done_yet?
    @walls_hit < 2
  end

  def pivot!
    @warrior.pivot!
  end

  def rescue!
    @warrior.rescue!
  end

  def rest!
    @warrior.rest!
  end

  def rested?
    @warrior.health == 20
  end

  def shoot!
    @warrior.shoot!
  end

  def took_damage?
    @took_damage
  end

  def walk!(direction=:forward)
    @warrior.walk! direction
  end
end
