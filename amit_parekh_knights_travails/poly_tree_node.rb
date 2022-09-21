class PolyTreeNode
    attr_accessor :value
    attr_reader :parent, :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        return if self.parent == node

        if self.parent
            self.parent.children.delete(self)
        end

        @parent = node

        self.parent.children << self unless self.parent.nil?

        self
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise error if child_node && !self.children.include?(child_node)
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if self.value == target_value

        self.children.each do |child|
            search_result = child.dfs(target_value)
            return search_result unless search_result.nil?
        end

        nil
    end

    def bfs(target_value)
        node_queue = [self]

        until node_queue.empty?
            node = node_queue.pop
            return node if node.value == target_value
            node.children.each { |child| node_queue.unshift(child) }
        end

        nil
    end
end