module Walker
  class Window
    include Gl, Glu, Glut

    attr_reader :controller
    attr_accessor :width, :height, :title, :framerate, :lights

    def initialize(controller)
      @controller = controller
      controller.window = self
      default_values!
      self.lights = []
    end

    def add_light_source(light)
      light.number = lights.size

      self.lights << light
    end

    def default_values!
      self.framerate = 60
      self.width = 700
      self.height = 450
      self.title = "Ruby OpenGL"
    end

    def views
      @views ||= []
    end

    def display
      controller.fire_events
      redraw
    end

    def redraw
      glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
      glLoadIdentity
      views.each do |view|
        view.draw!
      end
      glFinish
      glutSwapBuffers
    end

    def timer(value)
      glutPostRedisplay
      start_timer
    end

    def start_timer
      glutTimerFunc 1000 / framerate, method(:timer).to_proc, nil
    end

    def enter_full_screen
      glutFullScreen
    end

    def leave_full_screen
      glutReshapeWindow(width, height)
    end

    def reshape(width, height)
      glViewport 0, 0, width, height
      glMatrixMode(GL_PROJECTION)
      glLoadIdentity
      gluPerspective(18, width / height, 1e4, 1e11)
      glMatrixMode(GL_MODELVIEW)
    end

    def start
      glutInit
      glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH)

      glutInitWindowSize(width, height)
      glutCreateWindow(title)
      glClearColor(0,0,0,0)
      glClearDepth(1.0)
      glDepthFunc(GL_LESS)
      glEnable(GL_DEPTH_TEST)
      glShadeModel(GL_SMOOTH)
      #glEnable( GL_CULL_FACE )

      glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)

      #default lighting and lighting position
      glEnable(GL_LIGHTING)
      glEnable(GL_LIGHT0)
      glLightfv(GL_LIGHT0, GL_DIFFUSE, [1, 1, 1])
      glLightfv(GL_LIGHT0, GL_POSITION, [0, 3, 0, 0])

      lights.each(&:activate)



      Textures.instance.load_all

      start_timer

      glutDisplayFunc method(:display).to_proc
      glutReshapeFunc method(:reshape).to_proc

      glutKeyboardFunc   controller.method(:key_press).to_proc
      glutSpecialFunc    controller.method(:special_key_press).to_proc
      glutSpecialUpFunc  controller.method(:special_key_up).to_proc
      glutKeyboardUpFunc controller.method(:key_up).to_proc

      glutMainLoop
    end

  end
end
