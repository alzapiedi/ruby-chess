class EmptySpaceError < StandardError
  def message
    "There is no piece at that position"
  end
end

class OutOfBoundsError < StandardError
  def message
    "That position is out of bounds"
  end
end

class IllegalMoveError < StandardError
  def message
    "That piece can't move there"
  end
end

class OtherColorError < StandardError
  def message
    "You don't have control of that color piece"
  end
end

class InCheckError < StandardError
  def message
    "You can't make a move that puts you in check"
  end
end
