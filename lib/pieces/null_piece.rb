class NullPiece

  include Singleton

  attr_reader :color

  def initialize
    @color = nil
  end

  def to_symbol
    self.class.to_s.downcase.to_sym
  end

  def dup(_)
    self
  end

end
