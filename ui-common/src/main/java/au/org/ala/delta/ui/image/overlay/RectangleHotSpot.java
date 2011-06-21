package au.org.ala.delta.ui.image.overlay;

import java.awt.Graphics;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import au.org.ala.delta.model.image.ImageOverlay;

/**
 * An RectangleHotSpot draws and implements detection based on an rectangular shaped
 * HotSpot.
 */
public class RectangleHotSpot extends HotSpot implements MouseListener {

	private static final long serialVersionUID = 1190841871644406245L;

	public RectangleHotSpot(ImageOverlay overlay, int index) {
		super(overlay, index);
		addMouseListener(this);
	}
	
	protected void drawHotSpot(Graphics g) {
		Rectangle bounds = getBounds();
		g.drawRect(0, 0, bounds.width-1, bounds.height-1);
	}
	
	@Override
	public void mouseEntered(MouseEvent e) {
		fireHotSpotEntered();
	}

	@Override
	public void mouseExited(MouseEvent e) {
		fireHotSpotExited();
	}
	
	@Override
	public void mouseClicked(MouseEvent e) {}

	@Override
	public void mousePressed(MouseEvent e) {}

	@Override
	public void mouseReleased(MouseEvent e) {}

}