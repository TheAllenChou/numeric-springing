using UnityEngine;
using System.Collections;

public class QuaternionSpring : MonoBehaviour {

	float x, v, xt;
	Vector3 dir;

	// Use this for initialization
	void Start () {
		x = 0.0f;
		v = 0.0f;
		xt = 0.0f;
	}

	float mx, my;

	// Update is called once per frame
	void Update () {

		if (Input.GetMouseButtonDown(0)) {
			Vector3 m = Input.mousePosition;
			mx = m.x;
			my = m.y;
		}

		if (Input.GetMouseButton(0)) {
			Vector3 m = Input.mousePosition;
			float dx = m.x - mx;
			float dy = m.y - my;
			float r = Mathf.Sqrt (dx * dx + dy * dy);
			if (r > 1.0f) {
				x = r;
				dir.Set (dx, 0.0f, dy);
			}
		} else {
			Spring (ref x, ref v, xt, 0.23f, 8.0f * Mathf.PI, Time.deltaTime);
		}
		transform.rotation = Quaternion.AngleAxis (x, Vector3.Cross (Vector3.up, dir));
	}

	void Spring  
		(  
		 ref float x, ref float v, float xt, 
		 float zeta, float omega, float h  
		 )  
	{  
		float f = 1.0f + 2.0f * h * zeta * omega;  
		float oo = omega * omega;  
		float hoo = h * oo;  
		float hhoo = h * hoo;  
		float detInv = 1.0f / (f + hhoo);  
		float detX = f * x + h * v + hhoo * xt;  
		float detV = v + hoo * (xt - x);  
		x = detX * detInv;  
		v = detV * detInv;  
	}   
}
