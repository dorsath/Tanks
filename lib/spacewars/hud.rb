class Hud

end

class HudView < Walker::View
  def draw!
    width, height = 700, 450
    glDisable(GL_DEPTH_TEST)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluOrtho2D(0, width, 0, height)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity
    # glDepthFunc(GL_LESS);

    glColor(0.5,0.5,0.5)
    glBegin(GL_QUADS)
    glVertex(0  , 100)
    glVertex(100, 100)
    glVertex(100, 0)
    glVertex(0  , 0)
    glEnd

    # glDepthMask(GL_TRUE);
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity
    gluPerspective(18, width / height, 1e5, 1e18)
    glMatrixMode(GL_MODELVIEW)
    glLoadIdentity
  end
end
