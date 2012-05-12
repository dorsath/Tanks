class CelestialBodyView < Walker::View
  def draw
    mult_matrix(@model.matrix)

    texture = Walker::Textures.instance.find(@model.texture,2)

    glMaterial(GL_FRONT_AND_BACK, GL_EMISSION, [0.5, 0.5, 0.5, 0.5])

    glRotate(90,-1,0,0) #fix sideway texture..

    quadro = gluNewQuadric();
    gluQuadricNormals(quadro, GLU_SMOOTH);
    gluQuadricTexture(quadro, GL_TRUE);
    glEnable(GL_TEXTURE_2D);

    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
    glBindTexture(GL_TEXTURE_2D, texture);
    gluSphere(quadro, @model.radius, 360, 360);


    glDisable(GL_TEXTURE_2D);
    gluDeleteQuadric(quadro);
  end
end
